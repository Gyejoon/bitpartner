package com.bitpartner.allspark.controller;

import com.bitpartner.allspark.Constant;
import com.bitpartner.allspark.common.MailEntity;
import com.bitpartner.allspark.common.MailService;
import com.bitpartner.allspark.domain.CertCode;
import com.bitpartner.allspark.domain.CertCodeRepository;
import com.bitpartner.allspark.domain.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
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
import java.util.Random;

@Controller
@RequestMapping(value = "/ico/allspark/recom")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CertCodeRepository certCodeRepository;

    /**
     * eventPage 접속 Url
     * 메인 이벤트 페이지
     *
     * @return
     */
    @GetMapping("/event")
    public String eventPage(Model model, @RequestParam(name = "recomdId", required = false) String recomdId) {
        if (recomdId != null) {
            BASE64Decoder base64Decoder = new BASE64Decoder();

            try {
                String decodedRecomdId = new String(base64Decoder.decodeBuffer(recomdId));
                int certKeylocation = decodedRecomdId.indexOf(Constant.CERT_KEY);
                String certKey = decodedRecomdId.substring(certKeylocation);
                String originRecomdId = decodedRecomdId.substring(0, certKeylocation);

                if (certKey.equals(Constant.CERT_KEY)) {
                    model.addAttribute("recomdId", originRecomdId);
                }

            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "event";
    }

    /**
     * 신청하기
     *
     * @param member
     * @return
     */
    @PostMapping("/apply")
    @ResponseBody
    public Map<String, Object> apply(@RequestBody @Valid Member member) {

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
     *
     * @param member
     * @return
     */
    @PostMapping("/recommend")
    @ResponseBody
    public Map<String, Object> recommend(@RequestBody @Valid Member member) {
        Member finededMember = memberService.findByMemberIdAndPass(member.getMemberId(), member.getMemberPassword());
        BASE64Encoder base64Encoder = new BASE64Encoder();
        String encodedId = base64Encoder.encode((finededMember.getMemberId() + Constant.CERT_KEY).getBytes());
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("member", finededMember);
        resultMap.put("recomUrl", Constant.EVENT_URL + "?recomdId=" + encodedId);

        return resultMap;
    }

    /**
     * 아이디 중복체크
     *
     * @param memberId
     * @return
     */
    @GetMapping("/idCheck")
    @ResponseBody
    public Map<String, Object> idCheck(@RequestParam("memberId") String memberId) {

        Map<String, Object> resultMap = new HashMap<String, Object>();

        Member findedMember = memberService.findByMemberId(memberId);

        if (findedMember != null) {
            resultMap.put("code", Constant.IS_USED_FAILED_CODE);
            resultMap.put("msg", Constant.IS_USED_FAILED);
        } else {
            resultMap.put("code", Constant.IS_USED_SUCCESS_CODE);
            resultMap.put("msg", Constant.IS_USED_SUCCESS);
        }

        return resultMap;
    }

    /**
     * 이메일 인증코드 발송
     */
    @GetMapping("/certCodeSend")
    @ResponseBody
    public Map<String, Object> certCodeSend(@RequestParam("email") String email) {

        Random r = new Random();
        int start = 1000;
        int end = 9999;

        double range = end - start + 1;
        int i = (int) (r.nextDouble() * range + start);
        int j = (int) (r.nextFloat() * range + end) << 2;

        BASE64Encoder base64Encoder = new BASE64Encoder();
        String certCodeStr = base64Encoder.encode(String.valueOf(i + j).getBytes());

        CertCode findedCertCode = certCodeRepository.emailCheck(email);

        if(findedCertCode != null)
            certCodeRepository.delete(findedCertCode);

        CertCode certCode = new CertCode();

        certCode.setEmail(email);
        certCode.setCode(certCodeStr);

        certCodeRepository.save(certCode);

		MailEntity mailEntity = new MailEntity(
				Constant.GMAIL_ID,
				Constant.GMAIL_NAME,
				email,
				Constant.GMAIL_SUBJECT,
                certCodeStr
		);

        MailService mailService = new MailService(
                Constant.GMAIL_HOST,
                Constant.GMAIL_PORT,
                Constant.GMAIL_ID,
                Constant.GMAIL_PW,
                true
        );
        mailService.send(mailEntity);

        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("success", true);

        return resultMap;
    }

    /**
     * 인증 번호 유효성 검사
     */
    @PostMapping("/certCodeCheck")
    @ResponseBody
    public Map<String, Object> certCodeCheck(@RequestBody @Valid CertCode certCode) {

        CertCode findedCode = certCodeRepository.certCodeCheck(certCode.getEmail(), certCode.getCode());

        Map<String, Object> resultMap = new HashMap<>();

        if(findedCode != null)
            resultMap.put("success", true);
        else
            resultMap.put("success", false);

        return resultMap;
    }


}