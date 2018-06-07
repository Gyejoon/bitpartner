package com.bitpartner.allspark.controller;

import com.bitpartner.allspark.Constant;
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
    public String eventPage(Model model,  @RequestParam(name = "recomdId", required = false) String recomdId) {
        if(recomdId != null) {
            BASE64Decoder base64Decoder = new BASE64Decoder();

            try{
                String decodedRecomdId = new String(base64Decoder.decodeBuffer(recomdId));
                int certKeylocation = decodedRecomdId.indexOf(Constant.CERT_KEY);
                String certKey = decodedRecomdId.substring(certKeylocation);

                if(certKey.equals(Constant.CERT_KEY)) {
                    model.addAttribute("recomdId", decodedRecomdId);
                }

            }catch(IOException e) {
                e.printStackTrace();
            }catch (Exception e) {
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
     * @param member
     * @return
     */
    @PostMapping("/recommend")
    @ResponseBody
    public Map<String, Object> recommend(@RequestBody @Valid Member member) {

        Member finededMember = memberService.findByMemberIdAndPass(member.getMemberId(), member.getMemberPassword());

        BASE64Encoder base64Encoder = new BASE64Encoder();
        String encodedId = base64Encoder.encode( (finededMember.getMemberId() + Constant.CERT_KEY).getBytes());

        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("member", finededMember);
        resultMap.put("recomUrl", Constant.EVENT_URL + "?recomdId=" + encodedId);

        return resultMap;
    }

    /**
     * 아이디 중복체크
     * @param memberId
     * @return
     */
    @GetMapping("/idCheck")
    @ResponseBody
    public Map<String, Object> idCheck(@RequestParam("memberId") String memberId) {

        Map<String, Object> resultMap = new HashMap<String, Object>();

        Member findedMember = memberService.findByMemberId(memberId);

        if(findedMember != null) {
            resultMap.put("code", Constant.IS_USED_FAILED_CODE);
            resultMap.put("msg", Constant.IS_USED_FAILED);
        } else {
            resultMap.put("code", Constant.IS_USED_SUCCESS_CODE);
            resultMap.put("msg", Constant.IS_USED_SUCCESS);
        }

        return resultMap;
    }

}