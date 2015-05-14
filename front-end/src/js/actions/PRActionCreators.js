'use strict';

let Api = require('../utils/Api');
let AppDispatcher = require('../dispatchers/AppDispatcher');

module.exports = {

  loadPRsFromServer: function () {
    Api.getPRData();
  },

  handleServerResponse: function (type, state, result, params) {
    AppDispatcher.handleServerAction({
      type, state, result, params
    });
  }
};
