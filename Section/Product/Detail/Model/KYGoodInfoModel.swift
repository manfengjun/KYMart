//
//  KYGoodInfo.swift
//  KYMart
//
//  Created by jun on 2017/6/8.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit



class Recommend_goods :NSObject{
    var shop_price: String!
    var goods_name: String!
    var goods_id: Int = 0
    
}

class Spec_list :NSObject{
    var item_id: Int = 0
    var src: String!
    var item: String!
    
}

class Goods_spec_list :NSObject{
    var spec_name: String!
    var spec_list: [Spec_list]!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["spec_list" : Spec_list.classForCoder()]
    }

}

class Goods :NSObject{
    var is_recommend: Int = 0
    var prom_is_able: Int = 0
    var cat_id2: Int = 0
    var goods_remark: String!
    var last_update: Int = 0
    var original_img: String!
    var sales_sum: Int = 0
    var suppliers_id: String!
    var store_cat_id2: Int = 0
    var shipping_area_ids: String!
    var cost_price: String!
    var is_free_shipping: Int = 0
    var cat_id1: Int = 0
    var close_reason: String!
    var goods_attr_list: String!
    var is_new: Int = 0
    var brand_id: Int = 0
    var is_virtual: Int = 0
    var sort: Int = 0
    var give_integral: Int = 0
    var spu: String!
    var virtual_limit: Int = 0
    var is_on_sale: Int = 0
    var goods_state: Int = 0

    var goods_sn: String!
    var goods_type: Int = 0
    var sku: String!
    var prom_type: Int = 0
    var collect_sum: Int = 0
    var comment_count: Int = 0
    var goods_id: Int = 0
    var shop_price: String!
    var goods_name: String!
    var is_own_shop: Int = 0
    var market_price: String!
    var goods_content: String!
    var store_cat_id1: Int = 0
    var store_id: Int = 0
    var prom_id: Int = 0
    var store_count: Int = 0
    var keywords: String!
    var cat_id3: Int = 0
    var distribut: String!
    var weight: Int = 0
    var exchange_integral: Int = 0
    var click_count: Int = 0
    var virtual_indate: Int = 0
    var on_time: Int = 0
    var virtual_refund: Int = 0
    var is_hot: Int = 0
    var ky_type: Int = 0

    
}

class Gallery :NSObject{
    var image_url: String!
    
}
class Data :NSObject{
    var title: String!
    var content: String!
    
}
class Activity :NSObject{
    var prom_type: Int = 0
    var data: [Data]!
    var prom_start_time: Int = 0
    var prom_price: Int = 0
    var prom_end_time: Int = 0
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["data" : Data.classForCoder()]
    }
}

class Spec_goods_price :NSObject{
    var key_name: String!
    var store_count: Int = 0
    var key: String!
    var price: String!
    
}

class Comment :NSObject{
    var is_anonymous: Int = 0
    var spec_key_name: String!
    var zan_num: Int = 0
    var impression: String!
    var parent_id: Int = 0
    var goods_rank: String!
    var order_id: Int = 0
    var user_id: Int = 0
    var img: String!
    var deleted: Int = 0
    var is_show: Int = 0
    var zan_userid: String!
    var comment_id: Int = 0
    var goods_id: Int = 0
    var store_id: Int = 0
    var reply_num: Int = 0
    var add_time: Int = 0
    var ip_address: String!
    var content: String!
    
}


class Statistics :NSObject{
    var c0: Int = 0
    var c3: Int = 0
    var rate2: Int = 0
    var c1: Int = 0
    var c4: Int = 0
    var rate1: Int = 0
    var rate3: Int = 0
    var c2: Int = 0
    
}

class Store :NSObject{
    var store_decoration_switch: Int = 0
    var store_zip: String!
    var store_theme: String!
    var pending_money: String!
    var latitude: String!
    var user_id: Int = 0
    var store_free_time: String!
    var store_collect: Int = 0
    var store_phone: String!
    var company_name: String!
    var store_workingtime: String!
    var qitian: Int = 0
    var mb_slide_url: String!
    var deposit: String!
    var store_deliverycredit: String!
    var store_logo: String!
    var city_id: Int = 0
    var longitude: String!
    var store_time: Int = 0
    var mb_slide: String!
    var store_sort: Int = 0
    var bind_all_gc: Int = 0
    var store_domain: String!
    var sc_id: Int = 0
    var seller_name: String!
    var store_zy: String!
    var deliver_region: String!
    var store_printdesc: String!
    var store_desccredit: String!
    var store_decoration_only: Int = 0
    var seo_keywords: String!
    var deposit_icon: Int = 0
    var store_slide_url: String!
    var deleted: Int = 0
    var store_state: Int = 0
    var store_aliwangwang: String!
    var store_end_time: String!
    var store_qq: String!
    var grade_id: Int = 0
    var cod: Int = 0
    var store_free_price: String!
    var store_avatar: String!
    var store_recommend: Int = 0
    var seo_description: String!
    var store_id: Int = 0
    var store_name: String!
    var district: Int = 0
    var store_warning_storage: Int = 0
    var is_own_shop: Int = 0
    var store_address: String!
    var store_money: String!
    var store_rebate_paytime: String!
    var returned: Int = 0
    var store_presales: String!
    var service_phone: String!
    var store_credit: Int = 0
    var goods_examine: Int = 0
    var certified: Int = 0
    var store_slide: String!
    var store_close_info: String!
    var store_banner: String!
    var store_aftersales: String!
    var store_servicecredit: String!
    var user_name: String!
    var two_hour: Int = 0
    var ensure: Int = 0
    var store_sales: Int = 0
    var province_id: Int = 0
    
}

class KYGoodInfoModel :NSObject{
    var recommend_goods: [Recommend_goods]!
    var goods: Goods!
    var gallery: [Gallery]!
    var activity: [Activity]!
    var spec_goods_price: [Spec_goods_price]!
    var comment: [Comment]!
    var statistics: Statistics!
    var store: Store!
    var goods_spec_list: [Goods_spec_list]!
    class func modelContainerPropertyGenericClass() -> NSDictionary {
        return ["goods_spec_list" : Goods_spec_list.classForCoder(),"recommend_goods" : Recommend_goods.classForCoder(),"gallery" : Gallery.classForCoder(),"activity" : Activity.classForCoder(),"spec_goods_price" : Spec_goods_price.classForCoder(),"comment" : Comment.classForCoder()]
    }

}

