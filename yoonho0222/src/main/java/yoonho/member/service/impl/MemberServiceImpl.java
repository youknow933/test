package yoonho.member.service.impl;

import java.awt.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import yoonho.member.mapper.MemberMapper;
import yoonho.member.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	/**
	 * @param vo
	 * @return int
	 */
	public int selectMemberCount() {
		int result = memberMapper.selectMemberCount();
		return result;
	}
	
	public ArrayList<Map<String, Object>> selectMember() {
    ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    list = memberMapper.selectMember();
    return list; 
  }

} 
 