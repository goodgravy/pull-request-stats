'use strict';

const moment = require('moment');

let Decorate = {
  prOpenTime (pr) {
    if (!pr.hasOwnProperty('derived')) { pr.derived = {}; }

    if (pr.attributes.created_at && pr.attributes.closed_at) {
      pr.derived.open_for = ( // eslint-disable-line camelcase
        moment(pr.attributes.closed_at) -
        moment(pr.attributes.created_at)
      );
    }
    return pr;
  }
};

let Aggregate = {
  prOpenTime (prs, period, prFunction) {
    if (prs.length === 0) { return {}; }

    let prBuckets = {},
      valueBuckets = {},
      sum = (a, b) => a + b,
      current = moment(prs[0].attributes.created_at),
      end = moment(prs[prs.length - 1].attributes.created_at);

    while (current <= end) {
      current.add(period);
      let currentBucket = prBuckets[current.toISOString()] = [];

      while (prs.length > 0 && moment(prs[0].attributes.created_at) <= current) {
        currentBucket.push(prs.shift());
      }
    }

    for (let bucketEnd in prBuckets) {
      let prs = prBuckets[bucketEnd];
      if (prs.length === 0) {
        valueBuckets[bucketEnd] = 0;
        continue;
      }

      let bucketTotal = prs
        .map(prFunction)
        .reduce(sum);
      valueBuckets[bucketEnd] = bucketTotal / prs.length;
    }

    return valueBuckets;
  }
};

module.exports = { Aggregate, Decorate };
