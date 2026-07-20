package pjt.prog01000.service.impl;

import java.util.List;
import java.util.Map;

public interface PROG01000Mapper {

    public List<Map<String, Object>> selectPROG01000Lst(Map<String, Object> param);
    public int selectPROG01000LstCnt(Map<String, Object> param);

}
