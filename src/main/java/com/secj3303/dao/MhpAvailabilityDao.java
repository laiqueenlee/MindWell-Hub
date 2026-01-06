package com.secj3303.dao;

import com.secj3303.model.MhpAvailability;
import java.util.List;

public interface MhpAvailabilityDao {
    void save(MhpAvailability availability);
    void delete(Integer id);
    List<MhpAvailability> findByMhpId(Integer mhpId);
    List<MhpAvailability> findAll();
}
