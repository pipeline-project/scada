var Step = React.createClass({
  render: function() {
    return (
      <tr>
        <td>{this.props.step.created_at}</td>
        <td>{this.props.step.name}</td>
        <td>
          <a href={'/pipelines/' + this.props.step.pipeline_id }>Pipeline</a>      
        </td>
        <td>{this.props.step.updated_at}</td>
      </tr>
    )
  }
});
