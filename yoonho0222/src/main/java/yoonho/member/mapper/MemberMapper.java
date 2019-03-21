package yoonho.member.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberMapper {
	/**
	 * @param vo
	 * @return Integer
	 */
	public int selectMemberCount();
	public  ArrayList<Map<String, Object>> selectMember();
}
