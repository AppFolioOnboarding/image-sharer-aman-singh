import React, { Component } from 'react';
import { inject, observer } from 'mobx-react';
import { Row, Col, Alert } from 'reactstrap';
import PropTypes from 'prop-types';

@observer
class FeedbackForm extends Component {
  store = this.props.stores.feedbackStore;

  onSubmit = (e) => {
    e.preventDefault();
    this.store.onSubmit();
  };

  render() {
    return (
      <div>
        <Row>
          <Col lg={{ size: 4, offset: 4 }}>
            <Alert
              color={this.store.alert.level}
              isOpen={!!this.store.alert.level}
            >
              {this.store.alert.message}
            </Alert>
            <form onSubmit={this.onSubmit}>
              <div className="form-group">
                <p id="name">Your Name:</p>
                <input
                  type="text"
                  className="form-control"
                  required
                  onChange={(e) => {
                    this.store.setName(e.target.value);
                }}
                />
              </div>
              <div className="form-group">
                <p id="comment">Comments:</p>
                <textarea
                  className="form-control"
                  required
                  onChange={(e) => {
                    this.store.setComment(e.target.value);
                          }}
                />
              </div>
              <button type="submit" className="btn btn-primary">Submit</button>
            </form>
          </Col>
        </Row>
      </div>
    );
  }
}

FeedbackForm.propTypes = {
  stores: PropTypes.object
};

export default inject('stores')(FeedbackForm);
