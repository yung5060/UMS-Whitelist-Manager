package com.kbank.yung.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kbank.yung.dao.WhitelistMapper;
import com.kbank.yung.dto.WhitelistDto;
import com.kbank.yung.entity.Whitelist;

@Service
public class WhitelistService {

	@Autowired
	WhitelistMapper mapper;
	
	public void saveWhiteMember(WhitelistDto whitelistDto) {
		
		for (int i = 0; i < whitelistDto.getChannelCodes().length(); i += 2) {
			Whitelist whitelist = new Whitelist();
			whitelist.setUMS_VAL(String.valueOf(whitelistDto.getChannelCodes().charAt(i)));
			whitelist.setCUST_INFO(whitelistDto.getPhoneNumber());
			try {
				mapper.saveWhiteMember(whitelist);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void deleteWhiteMember(String umsVal, String custInfo) {
		
		Whitelist whitelist = new Whitelist();
		whitelist.setUMS_VAL(umsVal);
		whitelist.setCUST_INFO(custInfo);
		try {
			mapper.deleteWhiteMember(whitelist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}