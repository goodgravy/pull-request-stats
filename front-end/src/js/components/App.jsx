'use strict';

const Router = require('react-router');

const mui = require('material-ui');
const React = require('react');
const Navigation = Router.Navigation;
const RouteHandler = Router.RouteHandler;

let {RaisedButton} = mui;

let App = React.createClass({
  mixins: [Navigation],

  contextTypes: {
    router: React.PropTypes.func
  },

  graphClick () {
    let {router} = this.context;
    router.transitionTo('/graph');
  },

  listClick () {
    let {router} = this.context;
    router.transitionTo('/list');
  },

  render() {
    return (
      <div>
        <header>
          <ul>
            <li>
              <RaisedButton label='List' onClick={this.listClick} />
              <RaisedButton label='Graph' onClick={this.graphClick} />
            </li>
          </ul>
        </header>

        <RouteHandler/>
      </div>
    );
  }

});

module.exports = App;
