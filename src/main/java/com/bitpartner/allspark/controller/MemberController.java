package com.bitpartner.allspark.controller;

import com.bitpartner.allspark.Constant;
import com.bitpartner.allspark.SHA256;
import com.bitpartner.allspark.common.MailEntity;
import com.bitpartner.allspark.common.MailService;
import com.bitpartner.allspark.domain.CertCode;
import com.bitpartner.allspark.domain.CertCodeRepository;
import com.bitpartner.allspark.domain.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.bitpartner.allspark.service.MemberService;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
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


    @GetMapping("/emailCheck")
    @ResponseBody
    public Map<String, Object> emailCheck(@RequestParam("email") String email) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        Member findedMember = memberService.emailCheck(email);

        if (findedMember != null) {
            resultMap.put("success", false);
            resultMap.put("code", Constant.IS_USED_FAILED_CODE);
            resultMap.put("msg", Constant.IS_USED_FAILED);
        } else {
            resultMap.put("success", true);
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

        Member findedMember = memberService.emailCheck(email);

        Map<String, Object> resultMap = new HashMap<String, Object>();


        if(findedMember != null) {
            resultMap.put("success", false);
            resultMap.put("duplicate", true);

            return resultMap;
        }

        Random r = new Random();
        int start = 1000;
        int end = 9999;

        double range = end - start + 1;
        int i = (int) (r.nextDouble() * range + start);

        String certCodeStr = SHA256.getEncSHA256(i + "").substring(0, 6);

        CertCode findedCertCode = certCodeRepository.emailCheck(email);

        if(findedCertCode != null)
            certCodeRepository.delete(findedCertCode);

        CertCode certCode = new CertCode();

        certCode.setEmail(email);
        certCode.setCode(certCodeStr);

        certCodeRepository.save(certCode);

        String mailContent = "[Bitpartner 회원가입 인증메일]\n\n";
        String mailContent2 = "Allspark Korea Special event 신청을 위한 Bitpartner 회원가입 인증번호 입니다.\n";
        String mailContent3 = "홈페이지에서 인증을 완료해주세요.\n\n";

        String mailContent4 = "인증번호: " + certCodeStr + "\n\n";
        String mailContent5 = "감사합니다.";


        MailEntity mailEntity = new MailEntity(
                Constant.GMAIL_ID,
                Constant.GMAIL_NAME,
                email,
                Constant.GMAIL_SUBJECT,
                mailContent + mailContent2 + mailContent3 +
                mailContent4 + mailContent5
        );

        MailService mailService = new MailService(
                Constant.GMAIL_HOST,
                Constant.GMAIL_PORT,
                Constant.GMAIL_ID,
                Constant.GMAIL_PW,
                true
        );
        mailService.send(mailEntity);

        resultMap.put("success", true);
        resultMap.put("duplicate", false);

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