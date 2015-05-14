'use strict';

const AppDispatcher = require('../dispatchers/AppDispatcher');
const Constants = require('../constants/AppConstants');
const BaseStore = require('./BaseStore');
const assign = require('object-assign');

// data storage
let _data = {};

// add private functions to modify data
function addPR(pr) {
  _data[pr.id] = pr;
}

function handlePrData (action) {
  switch(action.state) {
    case Constants.request.PENDING:
      break;
    case Constants.request.ERROR:
    case Constants.request.TIMEOUT:
      console.error(action);
      break;
    case Constants.request.COMPLETE:
      action.response.body.data.forEach(pr => addPR(pr));
      PRStore.emitChange();
      break;
    default:
      console.error('Unhandled action', action);
  }
}

// Facebook style store creation.
let PRStore = assign({}, BaseStore, {

  // public methods used by Controller-View to operate on data
  getAll() {
    return Object.keys(_data).sort().map(key => _data[key]);
  },

  getOne(prId) {
    return _data[prId];
  },

  // register store with dispatcher, allowing actions to flow through
  dispatcherIndex: AppDispatcher.register(function(payload) {
    let action = payload.action;

    switch(action.type) {
      case Constants.api.GET_PR_DATA:
        handlePrData(action);
        break;
    }
  })
});

module.exports = PRStore;
