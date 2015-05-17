var DocumentItem = React.createClass({

  propTypes: {
    document: React.PropTypes.object.isRequired
  },

  render: function() {
    return (
      <li>
        <a href={this.props.document.url}>{this.props.document.upload_file_name}</a>
      </li>
    )
  }

});
