package moo.ng.san.category.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CategoryDao {
	@Autowired
	private SqlSessionTemplate sqlSessoin;
}