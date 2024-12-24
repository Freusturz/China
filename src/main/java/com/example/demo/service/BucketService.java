package com.example.demo.service;

import com.example.demo.domain.Bucket;
import com.example.demo.domain.User;
import com.example.demo.dto.BucketDTO;

import java.util.List;

public interface BucketService {
    Bucket createBucket(User user, List<Long> productIds);

    void addProducts(Bucket bucket, List<Long> productIds);

    BucketDTO getBucketByUser(String name);
}
