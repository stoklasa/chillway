import React, { Component } from 'react';
import './style.css';
import {MapContainer} from './components/Map.js';
import {Icon} from './components/Misc.js';
import data from './data/icons_ref'
class App extends Component {

   render() {
    return (
      <div className="App">
        <img id="logo" src="https://scontent-frx5-1.xx.fbcdn.net/v/t1.15752-9/s2048x2048/34790182_1843090525711522_2402986691183771648_n.png?_nc_cat=0&oh=573518918849a1092fa14a30583b0b0a&oe=5BBB78EB" alt="logo"/>
        <MapContainer style="height:900px"/>
        <Icon key={1} name="My rules" imgsrc={data.settings}/>	
        <Icon key={2} name="Go!" imgsrc={data.go}/>	
        <Icon key={3} name="Add" imgsrc={data.add}/>	
      </div>
    );
  }
}

export default App;
