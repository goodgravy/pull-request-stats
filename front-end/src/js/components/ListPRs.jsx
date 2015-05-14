'use strict';

const ActionCreator = require('../actions/PRActionCreators');
const PRSummary = require('./PRSummary.jsx');
const PRStore = require('../stores/PRStore');
const React = require('react');
const RouteHandler = require('react-router').RouteHandler;

let ListPRs = React.createClass({

  getInitialState() {
    return {prs: []};
  },

  _onChange() {
    this.setState({prs: PRStore.getAll()});
  },

  componentDidMount() {
    ActionCreator.loadPRsFromServer();
    PRStore.addChangeListener(this._onChange);
  },

  componentWillUnmount() {
    PRStore.removeChangeListener(this._onChange);
  },

  render() {
    let {prs} = this.state;
    return (
      <div>
        <ul id='pr-list'>
          {prs.map(
            pr =>
              <li key={pr.id}>
                <PRSummary pr={pr} />
              </li>
            )}
          </ul>

          <RouteHandler />
        </div>
    );
  }
});

module.exports = ListPRs;
