<html>
<head>
<head>
  <title>Checkout</title>
  <script src="https://js.stripe.com/v3/"></script>

<style type="text/css">
body {
	background-image: url('https://cdn.crunchify.com/bg.png');
}
</style>
<script>
//Set your publishable key: remember to change this to your live publishable key in production
//See your keys here: https://dashboard.stripe.com/account/apikeys
var stripe = Stripe('pk_test_51HX7GBCWDJpaAHH9rXYvKmQsPULewKtj7hGG08Cv5pjLKvscLbpTj7vtU1Hjd1VZbOBULPRnwiUqdSCF8hwtUVPt00OGp6qW6D');
var elements = stripe.elements();
</script>
</head>
<body>getClientSecret = <div id=clientSecret>${message}</div>${message}
publicKey<div id=publicKey></div>

	<br>
	<br>
	<div
		style="font-family: verdana; padding: 10px; border-radius: 10px; font-size: 12px; text-align: center;">	
		<a href="processPayment.html">Click here to Make Payment</a>
		
<form id="payment-form">
  <div id="card-element">
    <!-- Elements will create input elements here -->
  </div>
  <!-- We'll put the error messages in this element -->
  <div id="card-errors" role="alert"></div>
  <button id="submit">Pay</button>
</form>
		
	</div>
</body>
<script>
document.getElementById("publicKey").innerHTML = stripe;

//Set up Stripe.js and Elements to use in checkout form
var elements = stripe.elements();
var style = {
  base: {
    color: "#32325d",
  }
};

var card = elements.create("card", { style: style });
card.mount("#card-element");

var form = document.getElementById('payment-form');
alert( document.getElementById('clientSecret').innerHTML );

var clientSecret; 
clientSecret = document.getElementById('clientSecret').innerHTML;

form.addEventListener('submit', function(ev) {
  ev.preventDefault();
  stripe.confirmCardPayment( document.getElementById('clientSecret').innerHTML , {
    payment_method: {
      card: card,
      billing_details: {
        name: 'Jenny Rosen'
      }
    }
  }).then(function(result) {
    if (result.error) {
      // Show error to your customer (e.g., insufficient funds)
      console.log(result.error.message);
      alert( result.error.message );

    } else {
      if (result.paymentIntent.status === 'succeeded') {
          alert(" The payment has been processed! ");
        // Show a success message to your customer
        // There's a risk of the customer closing the window before callback
        // execution. Set up a webhook or plugin to listen for the
        // payment_intent.succeeded event that handles any business critical
        // post-payment actions.
      }
    }
  });
});
</script>
</html>