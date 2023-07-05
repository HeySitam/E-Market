import 'package:goriber_marketplace/core/utils/enums.dart';

class APIResponse<F, S> {
  F? _failureResponse;
  S? _successResponse;
  ResponseState _state = ResponseState.IDLE;

  setFailureResponse(F failureRes) {
    _failureResponse = failureRes;
    _state = ResponseState.FAILURE;
  }

  setSuccessResponse(S successRes) {
    _successResponse = successRes;
    _state = ResponseState.SUCCESS;
  }

  startLoading() {
    _state = ResponseState.LOADING;
  }

  F? get failureResponse => _failureResponse;

  S? get successResponse => _successResponse;

  ResponseState get responseState => _state;
}
