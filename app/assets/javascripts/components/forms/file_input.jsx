var FileInput = React.createClass({

  propTypes: {
    onCreateDocument: React.PropTypes.func.isRequired
  },

  getInitialState: function() {
    return {
      errors: null,
      percentLoaded: null
    }
  },

  handleUploadFiles: function(e) {
    this.uploads = _.map(e.target.files, function(file) {
      return { name: file.name, size: file.size, loaded: 0 }
    });

    var _this = this;

    _.each(e.target.files, function(file) {
      FileStore.createResource(file, { onProgress: _this.handleProgress })
      .then(function(data) {
        _this.handleResourceCreated(file, data.document);
      })
      .fail(function(xhr) {
        _this.handleError(file, xhr);
      });
    });
  },

  handleProgress: function(file, loaded) {
    upload = _.find(this.uploads, { name: file.name });
    if (upload) { upload.loaded = loaded; }

    this.setState({
      percentLoaded: Math.round((_.sum(this.uploads, 'loaded') / _.sum(this.uploads, 'size')) * 100) + '%'
    });
  },

  handleError: function(file, xhr) {
    this.setState({ errors: file.name + ' failed to upload' });
  },

  handleResourceCreated: function(file, document) {
    this.uploads.splice(this.uploads.indexOf(file.name), 1);
    if (!this.uploads.length) {
      React.findDOMNode(this.refs.fileElement).value = null;
      this.setState({
        percentLoaded: null
      });
    }

    this.props.onCreateDocument(document);
  },

  render: function() {
    return (
      <div>
        <input ref="fileElement" type="file" multiple={true} onChange={this.handleUploadFiles} />
        <span>{this.state.percentLoaded}</span>
        <span>{this.state.errors}</span>
      </div>
    )
  }
});
