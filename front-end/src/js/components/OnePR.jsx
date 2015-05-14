'use strict';

const PRStore = require('../stores/PRStore');
const React = require('react');

let OnePR = React.createClass({

  contextTypes: {
    router: React.PropTypes.func
  },

  getInitialState() {
    return {};
  },

  _onChange() {
    this.setState(PRStore.getOne(this.context.router.getCurrentParams().prId));
  },

  componentWillMount() {
    this._onChange();
  },

  componentWillReceiveProps() {
    this._onChange();
  },

  componentDidMount() {
    PRStore.addChangeListener(this._onChange);
  },

  componentWillUnmount() {
    PRStore.removeChangeListener(this._onChange);
  },

  render() {
    return (
      <div>
        <code>{JSON.stringify(this.state)}</code>
      </div>
    );
  }
});

module.exports = OnePR;
