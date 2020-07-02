import React, { Component } from 'react';
import { inject, observer } from 'mobx-react';
import { Row, Col } from 'reactstrap';

@observer
class FeedbackForm extends Component {
  render() {
    return (
      <div>
        <Row>
          <Col lg={{ size: 4, offset: 4 }}>
            <form>
              <div className="form-group">
                <p id="name">Your Name:</p>
                <input
                  type="text"
                  className="form-control"
                  onChange={(e) => {
                  this.props.stores.feedbackStore.setName(e.target.value);
                }}
                />
              </div>
              <div className="form-group">
                <p id="comment">Comments:</p>
                <textarea
                  className="form-control"
                  onChange={(e) => {
                            this.props.stores.feedbackStore.setComment(e.target.value);
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

export default inject('stores')(FeedbackForm);
