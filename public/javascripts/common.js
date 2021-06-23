// eslint-disable-next-line no-unused-vars
function updateCartQty () {
  let cartArr = localStorage.getItem("cart");
  if (cartArr === null) {
    cartArr = [];
  } else {
    cartArr = JSON.parse(cartArr);
  }

  const cartCount = document.querySelector(".count");
  cartCount.innerHTML = cartArr.length;
}
