package pjt.prog01000.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pjt.prog01000.service.PROG01000Service;

import java.util.List;
import java.util.Map;
@Service
public class PROG01000ServiceImpl implements PROG01000Service {

    @Autowired
    PROG01000Mapper mapper;

    @Override
    public List<Map<String, Object>> selectPROG01000Lst(Map<String, Object> param) {
        return mapper.selectPROG01000Lst(param);
    }

    @Override
    public int selectPROG01000LstCnt(Map<String, Object> param) {
        return mapper.selectPROG01000LstCnt(param);
    }
}
