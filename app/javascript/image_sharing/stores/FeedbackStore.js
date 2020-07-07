import { observable, action } from 'mobx';
import PostFeedbackService from '../services/PostFeedbackService';

class FeedbackStore {
  name = null;
  comment = null;
  @observable alert = { level: null, message: null };

  setName = (name) => {
    this.name = name;
  };

  setComment = (comment) => {
    this.comment = comment;
  };

  @action
  onSubmit = () => {
    const onSuccess = () => {
      this.alert = { level: 'success', message: 'Feedback submitted!' };
    };

    const onFailure = () => {
      this.alert = { level: 'danger', message: 'Error submitting feedback, please try later.' };
    };

    return PostFeedbackService.addFeedback(this.name, this.comment).then(onSuccess, onFailure);
  };
}

export default FeedbackStore;
