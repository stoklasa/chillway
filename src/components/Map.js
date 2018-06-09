import React from "react"
import { compose, withProps } from "recompose"
import { withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps"


const MapComponent = compose(
  withProps({
    googleMapURL: "https://maps.googleapis.com/maps/api/js?key=AIzaSyA8fgaZuAaRznJ_yVypajySOoUObqI6vW0&v=3.exp&libraries=geometry,drawing,places",
    loadingElement: <div style={{ height: `100%` }} />,
    containerElement: <div style={{ height: `400px` }} />,
    mapElement: <div style={{ height: `100%` }} />,
  }),
  withScriptjs,
  withGoogleMap
)((props) => 
  <GoogleMap
    defaultZoom={14}
    defaultCenter={{ lat: 50.1234, lng: 14.4344 }}
  >
  {props.results.map((obj,index) => <Marker key={index} position={{ lat:parseFloat(obj[2]), lng:parseFloat(obj[3]) }} onClick={props.onMarkerClick} />
  )}
  </GoogleMap>
)
export class MapContainer extends React.PureComponent {
  state = {
    isMarkerShown: false,
    results:[],
    isLoading:false 
    }
	componentDidMount() {
    fetch('http://chillway.kubabednar.cz/api.php?action=around&sirka=50.107820&delka=14.429592')
      .then(results => { return results.json();})
      .then(data => {
        this.setState({
          results:data,
          isLoading: false
        }); 
    });
  }
  delayedShowMarker = () => {
    setTimeout(() => {
      this.setState({ isMarkerShown: true })
    }, 3000)
  }

  handleMarkerClick = () => {
    this.setState({ isMarkerShown: false })
    this.delayedShowMarker()
  }
  render() {
    return !this.state.isLoading?  (
      <MapComponent
        results = {this.state.results}
        isMarkerShown={this.state.isMarkerShown}
        onMarkerClick={this.handleMarkerClick}
      />
    ) : null;
  }
}
