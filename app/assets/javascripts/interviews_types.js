function checkMaxlength(object) {
  var iMaxLen = parseInt(object.getAttribute('maxlength'));
  var iCurLen = object.value.length;

  if(object.getAttribute && iCurLen > iMaxLen) {
    object.value = object.value.substring(0, iMaxLen);
  }
}
