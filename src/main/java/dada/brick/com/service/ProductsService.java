package dada.brick.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dada.brick.com.dao.ProductsDAO;
import dada.brick.com.vo.ProductsVO;

@Component("productsService")
public class ProductsService implements DataService<ProductsVO> {
	@Autowired
	ProductsDAO dao;
	
	@Override
	public int insert(ProductsVO input) {
		return dao.insert(input);
	}

	@Override
	public int update(ProductsVO input) {
		return dao.update(input);
	}

	@Override
	public int delete(ProductsVO input) {
		return dao.delete(input);
	}

	@Override
	public List<ProductsVO> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductsVO> select(ProductsVO input) {
		return dao.select(input);
	}

	@Override
	public ProductsVO selectOne(ProductsVO input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(ProductsVO input) {
		return dao.count(input);
	}

}
