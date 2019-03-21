package yoonho.member.service;

import java.awt.List;

import java.util.ArrayList;
import java.util.Map;

public interface MemberService {

	public int selectMemberCount();
	
	public  ArrayList<Map<String, Object>> selectMember();
	
} 
