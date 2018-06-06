package com.bitpartner.allspark.controller;

import com.bitpartner.allspark.domain.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.bitpartner.allspark.service.MemberService;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
	public String eventPage() {
		return "event";
	}

	/**
	 * recommendPage 접속 Url
	 * 추천하기 로그인 페이지
	 * @return
	 */
	@GetMapping("/recommend")
	public String recommendPage() { return "recommend"; }

	/**
	 * donePage 접속 Url
	 * 추천링크 페이지(신청하기 혹은 추천하기 완료 이후의 페이지)
	 */
	@GetMapping("/done")
	public String donePage(HttpServletRequest request) {
		return "done";
	}

	/**
	 * 신청하기
	 * @param member
	 * @return
	 */
	@PostMapping("/apply")
	@ResponseBody
	public Member apply(@RequestBody @Valid Member member) {
		return memberService.insertMember(member);
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
	public Member idCheck(@RequestParam("membetId") String memberId) {
		return memberService.findByMemberId(memberId);
	}


}
