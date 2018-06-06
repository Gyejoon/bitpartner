package com.bitpartner.allspark.controller;

import com.bitpartner.allspark.Constant;
import com.bitpartner.allspark.domain.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.bitpartner.allspark.service.MemberService;
import com.sun.istack.internal.Nullable;

import org.springframework.web.servlet.ModelAndView;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/ico/allspark/recom")
public class MemberController {

	@Autowired
	private MemberService memberService;

	/**
	 * eventPage 접속 Url
	 * 메인 이벤트 페이지
	 * @return
	 */
	@GetMapping("/event")
	public String eventPage(Model model,  @RequestParam(name = "recomId", required = false) String recomId) {
		if(recomId != null) {
			BASE64Decoder base64Decoder = new BASE64Decoder();
			try{
				String decodedRecomdId = new String(base64Decoder.decodeBuffer(recomId));

				if(decodedRecomdId.equals(recomId + Constant.CERT_KEY)) {
					model.addAttribute("recomId", decodedRecomdId);
				}
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
		return "event";
	}

	/**
	 * 신청하기
	 * @param member
	 * @return
	 */
	@PostMapping("/apply")
	@ResponseBody
	public Map<String, Object> apply(@RequestBody @Valid Member member, HttpServletRequest request) {

		Member insertedMember = memberService.insertMember(member);

		BASE64Encoder base64Encoder = new BASE64Encoder();
		String encodedId = base64Encoder.encode((insertedMember.getMemberId() + Constant.CERT_KEY).getBytes());

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("member", insertedMember);
		resultMap.put("recomUrl", Constant.EVENT_URL + "?recomdId=" + encodedId);

		return resultMap;
	}

	/**
	 * 추천하기
	 * @param member
	 * @return
	 */
	@PostMapping("/recommend")
	@ResponseBody
	public Member recommend(@RequestBody @Valid Member member) {
		return memberService.findByMemberIdAndPass(member.getMemberId(), member.getMemberPassword());
	}

	/**
	 * 아이디 중복체크
	 * @param memberId
	 * @return
	 */
	@GetMapping("/idCheck")
	@ResponseBody
	public Member idCheck(@RequestParam("memberId") String memberId) {
		return memberService.findByMemberId(memberId);
	}

}
