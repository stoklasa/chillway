import React from 'react';

export class Icon extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			name: this.props.name,
			source: this.props.imgsrc
		}
	}

	render() {
		return (
			<div className="icon" style={{ width: `33%`}}>
				<div  style={{display: `inline`}}>
						<img className="icon-img" src={this.state.source} alt='frontend sux'/>
				<div style={{display: `block`}}>
				<a>
						{this.state.name}
					</a>
				</div>
				</div>
			</div>
		);	
	}
}
