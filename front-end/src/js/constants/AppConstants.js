'use strict';

const keyMirror = require('react/lib/keyMirror');

module.exports = {

  ActionTypes: keyMirror({
  }),

  ActionSources: keyMirror({
    SERVER_ACTION: null,
    VIEW_ACTION: null
  }),

  request: keyMirror({
    PENDING: null,
    COMPLETE: null,
    TIMEOUT: null,
    ERROR: null
  }),

  api: keyMirror({
    GET_PR_DATA: null
  })
};
