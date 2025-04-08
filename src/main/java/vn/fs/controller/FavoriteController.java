package vn.fs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.fs.commom.CommomDataService;
import vn.fs.entities.Favorite;
import vn.fs.entities.Product;
import vn.fs.entities.User;
import vn.fs.repository.FavoriteRepository;
import vn.fs.repository.ProductRepository;

/**
 * @author KnowSphere
 *
 */
@Controller
public class FavoriteController extends CommomController {

	@Autowired
	FavoriteRepository favoriteRepository;

	@Autowired
	ProductRepository productRepository;

	@Autowired
	CommomDataService commomDataService;

	@GetMapping(value = "/favorite")
	public String favorite(Model model, User user) {
		List<Favorite> favorites = favoriteRepository.selectAllSaves(user.getUserId());
		commomDataService.commonData(model, user);
		model.addAttribute("favorites", favorites);
		return "web/favorite";
	}

	@GetMapping(value = "/doFavorite")
	public String doFavorite(Model model, Favorite favorite, User user, @RequestParam("id") Long id) {
		Product product = productRepository.findById(id).orElse(null);
		favorite.setProduct(product);
		favorite.setUser(user);
		product.setFavorite(true);
		favoriteRepository.save(favorite);
		commomDataService.commonData(model, user);
		return "redirect:/products";
	}

	@GetMapping(value = "/doUnFavorite")
	public String doUnFavorite(Model model, Product product, User user, @RequestParam("id") Long id) {
		// Lấy Favorite cần xóa dựa trên productId và userId
		Favorite favorite = favoriteRepository.selectSaves(id, user.getUserId());
		if (favorite != null) {
			// Xóa Favorite khỏi danh sách yêu thích
			favoriteRepository.delete(favorite);

			// Cập nhật trạng thái favorite của sản phẩm (nếu cần)
			product = productRepository.findById(id).orElse(null);
			if (product != null) {
				product.setFavorite(false); // Cập nhật trạng thái (nếu Product có trường này)
				productRepository.save(product); // Lưu thay đổi nếu cần
			}

			// Lấy danh sách Favorite còn lại của người dùng
			List<Favorite> remainingFavorites = favoriteRepository.findByUserUserId(user.getUserId());

			// Kiểm tra danh sách yêu thích còn sản phẩm không
			if (remainingFavorites != null && !remainingFavorites.isEmpty()) {
				// Nếu còn sản phẩm yêu thích, quay lại trang /favorite
				commomDataService.commonData(model, user);
				model.addAttribute("favorites", remainingFavorites); // Truyền danh sách yêu thích vào model
				return "redirect:/favorite"; // Quay lại trang yêu thích
			} else {
				// Nếu không còn sản phẩm yêu thích, chuyển hướng về /products
				commomDataService.commonData(model, user);
				return "redirect:/products";
			}
		}

		// Nếu không tìm thấy Favorite để xóa, chuyển về /products
		commomDataService.commonData(model, user);
		return "redirect:/products";
	}

}
