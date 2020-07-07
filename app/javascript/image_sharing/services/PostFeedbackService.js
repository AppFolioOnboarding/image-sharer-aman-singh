import { post } from '../utils/helper';

export default class PostFeedbackService {
  static addFeedback = (name, comment) => post('/api/feedbacks', { name, comment });
}
