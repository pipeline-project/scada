var Steps = React.createClass({
  getInitialState: function() {
    return {steps: this.props.data};
  },
  getDefaultProps: function() {
    return {steps: []}
  },
  render: function() {
    return (
      <div>
        <h1>Steps</h1>
        <table className='table'>
          <thead>
            <tr>
              <th>Created</th>
              <th>Name</th>
              <th>Pipeline</th>
              <th>Updated</th>
            </tr>
          </thead>
          <tbody>
            
              {this.state.steps.map(function(step) {
                return <Step key={step.id} step={step}/>;
              })}
            
          </tbody>
        </table>
      </div>
    )
  }
});
