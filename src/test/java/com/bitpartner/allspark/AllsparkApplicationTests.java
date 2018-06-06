package com.bitpartner.allspark;

import com.fasterxml.jackson.databind.ser.Serializers;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import sun.misc.BASE64Encoder;

import java.util.Base64;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AllsparkApplicationTests {

	@Test
	public void contextLoads() {
		BASE64Encoder encoder = new BASE64Encoder();
		String txtPlain = "javautil" + Constant.CERT_KEY;
		String txtCipher = "";
		System.out.println("Source String : " + txtPlain);
		txtCipher = encoder.encode(txtPlain.getBytes());
		System.out.println(txtCipher);
	}

}
