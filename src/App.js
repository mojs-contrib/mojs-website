import React from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';

import { Home } from './pages';

const BasicExample = () => (
  <Router>
    <div>
      <ul className="menu">
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/tutorials">Tutorials</Link>
        </li>
        <li>
          <a
            href="https://github.com/mojs-contrib/mojs/tree/master/api"
            target="_blank"
            rel="noopener noreferrer"
          >
            APIs
          </a>
        </li>
      </ul>

      <hr />

      <Route exact path="/" component={Home} />
      <Route path="/tutorials" component={Tutorials} />
    </div>
  </Router>
);

const Tutorials = ({ match }) => (
  <div>
    <h2>Tutorials</h2>

    <h3>Modules</h3>
    <ul>
      <li>
        <Link to={`${match.url}/shape-swirl`}>Shape & Swirl</Link>
      </li>
      <li>
        <Link to={`${match.url}/burst`}>Burst</Link>
      </li>
    </ul>

    <h3>Easing</h3>
    <ul>
      <li>
        <Link to={`${match.url}/path-easing`}>Path Easing</Link>
      </li>
    </ul>

    <Route path={`${match.url}/:topicId`} component={Tutorial} />
    <Route
      exact
      path={match.url}
      render={() => <h3>Please select a tutorial. More is on it's way</h3>}
    />
  </div>
);

const Tutorial = ({ match }) => (
  <div>
    <h3>{match.params.topicId}</h3>
  </div>
);

export default BasicExample;
