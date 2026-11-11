// Replace with the exact verified, hosted checkout address AFTER it has been created and tested.
const CHECKOUT_URL = 'YOUR_VERIFIED_CHECKOUT_URL_HERE';
const hasCheckout = /^https:\/\//.test(CHECKOUT_URL);
document.querySelectorAll('[data-checkout-link]').forEach(link => {
  if (hasCheckout) { link.href = CHECKOUT_URL; link.rel = 'noopener noreferrer'; }
  else { link.addEventListener('click', e => { e.preventDefault(); document.getElementById('checkout-warning').style.display = 'block'; document.getElementById('checkout-warning').scrollIntoView({behavior:'smooth'}); }); }
});