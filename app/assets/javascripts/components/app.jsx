var App = React.createClass({

  getInitialState: function() {
    return {
      documents: []
    }
  },

  componentDidMount: function() {
    FileStore.getResources()
    .then(function(data) {
      this.setState({ documents: data.documents });
    }.bind(this));
  },

  handleCreateDocument: function(document) {
    this.setState({ documents: $.merge([document], this.state.documents) });
  },

  render: function() {
    return (
      <div>
        <DocumentsList documents={this.state.documents} />
        <FileInput onCreateDocument={this.handleCreateDocument} />
      </div>
    )
  }
});
