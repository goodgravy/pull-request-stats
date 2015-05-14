'use strict';

const ActionCreator = require('../actions/PRActionCreators');
const LineChart = require('react-chartjs').Line;
const moment = require('moment');
const PRStore = require('../stores/PRStore');
const React = require('react');
const Stats = require('../utils/Stats');

let Graph = React.createClass({

  getStateFromStore () {
    return PRStore.getAll();
  },

  getInitialState() {
    return {prs: this.getStateFromStore()};
  },

  _onChange() {
    this.setState({prs: this.getStateFromStore()});
  },

  componentDidMount() {
    ActionCreator.loadPRsFromServer();
    PRStore.addChangeListener(this._onChange);
  },

  componentWillUnmount() {
    PRStore.removeChangeListener(this._onChange);
  },

  render() {

    let closedPRs = this.state.prs.filter(pr => pr.attributes.state === 'closed'),
      closedPRsWithOpenFor = closedPRs.map(Stats.Decorate.prOpenTime),
      prOpenTimeData = Stats.Aggregate.prOpenTime(
        closedPRsWithOpenFor,
        {weeks: 1},
        pr => pr.derived.open_for),
      bucketNames = Object.keys(prOpenTimeData),
      chartData = {
        labels: bucketNames.map(isoStr => moment(isoStr).format('MMMM Do YYYY')),
        datasets: [
          {
            label: 'PR open time',
            data: bucketNames.map(bucketName => prOpenTimeData[bucketName])
          }
        ]
      },
      chartOptions = {
        scaleLabel: payload => (payload.value / 1000 / 60 / 60 / 24).toFixed(0)
      };

    return (
      <LineChart data={chartData} options={chartOptions} width='600' height='250' redraw/>
    );
  }
});

module.exports = Graph;
