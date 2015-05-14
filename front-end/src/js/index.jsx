'use strict';

const React = require('react');
const App = require('./components/App.jsx');
const ListPRs = require('./components/ListPRs.jsx');
const OnePR = require('./components/OnePR.jsx');
const Graph = require('./components/Graph.jsx');
const Router = require('react-router');
const DefaultRoute = Router.DefaultRoute;
const Route = Router.Route;

var routes = (
  <Route path='/' handler={App}>
    <Route name='listPRs' path='/list' handler={ListPRs}>
      <Route name='onePr' path=':prId' handler={OnePR}/>
    </Route>
    <Route name='graph' path='/graph' handler={Graph}/>
    <DefaultRoute handler={ListPRs}/>
  </Route>
);

Router.run(routes, function (Handler) {
  React.render(<Handler/>, document.getElementById('main'));
});
