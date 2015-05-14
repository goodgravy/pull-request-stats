'use strict';

const React = require('react');
const Router = require('react-router');
const Link = Router.Link;

let PRSummary = React.createClass({
  getDefaultProps() {
    return {};
  },

  render() {
    let {pr} = this.props;
    return (
      <Link to='onePr' params={{prId: pr.id}}>
        {pr.id}: {pr.attributes.url}
      </Link>
    );
  }
});

module.exports = PRSummary;
