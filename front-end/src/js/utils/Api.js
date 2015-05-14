'use strict';

const AppDispatcher = require('../dispatchers/AppDispatcher');
const Constants = require('../constants/AppConstants');
const request = require('superagent');

let API_URL = 'http://192.168.99.100:3001/api/1.0.0';
let TIMEOUT = 10000;

let _pendingRequests = {};

function abortPendingRequests(key) {
  if (_pendingRequests[key]) {
    _pendingRequests[key]._callback = function(){};
    _pendingRequests[key].abort();
    _pendingRequests[key] = null;
  }
}

function makeUrl(part) {
  return API_URL + part;
}

function dispatch(key, state, response, params) {
  let action = {type: key, state: state, response: response};
  if (params) {
    action.queryParams = params;
  }
  AppDispatcher.handleServerAction(action);
}

// return successful response, else return request Constants
function makeDigestFun(key, params) {
  return function (err, res) {
    if (err && err.timeout === TIMEOUT) {
      dispatch(key, Constants.request.TIMEOUT, null, params);
    } else if (err || !res.ok) {
      dispatch(key, Constants.request.ERROR, null, params);
    } else {
      dispatch(key, Constants.request.COMPLETE, res, params);
    }
  };
}

// a get request with an authtoken param
function get(url) {
  return request
  .get(url)
  .timeout(TIMEOUT);
}

let Api = {
  getPRData: function() {
    let url = makeUrl('/pull_requests/');
    let key = Constants.api.GET_PR_DATA;
    let params = {};
    abortPendingRequests(key);
    dispatch(key, Constants.request.PENDING, params);
    _pendingRequests[key] = get(url).end(
      makeDigestFun(key, params)
    );
  }
};

module.exports = Api;
