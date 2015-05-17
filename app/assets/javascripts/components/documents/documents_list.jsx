var DocumentsList = React.createClass({

  propTypes: {
    documents: React.PropTypes.array.isRequired
  },

  render: function() {
    var documentItems = _.map(this.props.documents, function(document) {
      return <DocumentItem key={document.id} document={document} />;
    });

    return (
      <ul>
        {documentItems}
      </ul>
    )
  }

});
