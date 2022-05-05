abstract class CartStates{

}
class CartInitialState extends CartStates{}
class ItemAddedSuccessState extends CartStates{}
class ItemAddedErrorState extends CartStates{}
class ChangePlusState extends CartStates{}
class EmptyCartSuccessState extends CartStates{}
class RemoveItemSuccessState extends CartStates{}
class RemoveItemErrorState extends CartStates{}
class GetCartItemsSuccessState extends CartStates{}
class GetCartItemsErrorState extends CartStates{}
class GetCartItemsLoadingState extends CartStates{}
