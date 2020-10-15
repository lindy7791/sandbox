package com.springmvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;

@Controller
public class ControllerClass {
 
	@RequestMapping("/welcome")
	public ModelAndView helloWorld() {
		String message = "<br><div style='text-align:center;'>"
				+ "<h3>********** Initial Payment **********</div><br><br>";
		PaymentIntent pi = createPaymentIntent();
		return new ModelAndView("welcome", "message", pi.getClientSecret());
	}

	@RequestMapping("/checkout")
	public ModelAndView startCheckout() {
		String message = "<br><div style='text-align:center;'>"
				+ "<h3>********** Start Payment **********</div><br><br>";
		PaymentIntent pi = createPaymentIntent();
		return new ModelAndView("checkout", "message", pi.getClientSecret());
	}
	
	private static PaymentIntent createPaymentIntent() {
		Stripe.apiKey = "sk_test_51HX7GBCWDJpaAHH9bFsWA6UciAnRfJRtbt92arWNV9tflZ2CbcKmWeOC8KYjp02G9V8Oujpnr7AWQ8AmxXYZ1sx200pcXb493m";
		List<Object> paymentMethodTypes = new ArrayList<>();
		paymentMethodTypes.add("card");
		Map<String, Object> params = new HashMap<>();
		params.put("amount", 2000);
		params.put("currency", "usd");
		params.put(
		  "payment_method_types",
		  paymentMethodTypes
		);
		params.put("payment_method", "pm_card_visa");

		try {
			PaymentIntent paymentIntent = PaymentIntent.create(params);
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			System.out.println( "initial" + paymentIntent.toJson().toString());
			return paymentIntent;
					
		} catch (StripeException e) {
			e.printStackTrace();
		}
		return null;	
	}
	
	
	@RequestMapping("/processPayment")
	public ModelAndView pay() {
		String message = "<br><div style='text-align:center;'>"
				+ "<h3>********** Payment Confirmation **********</div><br><br>";
		return new ModelAndView("processPayment", "message", message);
	}	
}

