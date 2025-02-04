package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class ChinaShopApplication {

	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(ChinaShopApplication.class, args);
		PasswordEncoder encoder = context.getBean(PasswordEncoder.class);
		System.out.println(encoder.encode("pass"));
	}

}
