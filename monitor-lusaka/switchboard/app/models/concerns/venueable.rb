module Venueable
  extend ActiveSupport::Concern

  included do
    extend Enumerize
    enumerize :venue_type, in: {
      unspecified_unspecified: "0,0", 
      assembly_unspecified: "1,0",
      assembly_arena: "1,1",
      assembly_stadium: "1,2",
      assembly_terminal: "1,3",
      assembly_amphitheater: "1,4",
      assembly_amusement: "1,5",
      assembly_worship: "1,6",
      assembly_convention: "1,7",
      assembly_library: "1,8",
      assembly_museum: "1,9",
      assembly_restaurant: "1,10",
      assembly_theater: "1,11",
      assembly_bar: "1,12",
      assembly_coffee: "1,13",
      assembly_zoo: "1,14",
      assembly_emergency: "1,15",
      business_unspecified: "2,0",
      business_doctor: "2,1",
      business_bank: "2,2",
      business_fire: "2,3",
      business_police: "2,4",
      business_post: "2,6",
      business_professional: "2,7",
      business_research: "2,8",
      business_attorney: "2,9",
      educational_unspecified: "3,0",
      educational_primary: "3,1",
      educational_secondary: "3,2",
      educational_university: "3,3",
      factory_unspecified: "4,0",
      factory_factory: "4,1",
      institutional_unspecified: "5,0",
      institutional_hospital: "5,1",
      institutional_care: "5,2",
      institutional_rehab: "5,3",
      institutional_group: "5,4",
      institutional_prison: "5,5",
      mercantile_unspecified: "6,0",
      mercantile_retail: "6,1",
      mercantile_grocery: "6,2",
      mercantile_garage: "6,3",
      mercantile_mall: "6,4",
      mercantile_petrol: "6,5",
      residential_unspecified: "7,0",
      residential_private: "7,1",
      residential_hotel: "7,2",
      residential_dormitory: "7,3",
      residential_boarding: "7,4",
      storage_unspecified: "8,0",
      utility_unspecified: "9,0",
      vehicular_unspecified: "10,0",
      vehicular_automobile: "10,1",
      vehicular_airplane: "10,2",
      vehicular_bus: "10,3",
      vehicular_ferry: "10,4",
      vehicular_ship: "10,5",
      vehicular_train: "10,6",
      vehicular_bike: "10,7",
      outdoor_unspecified: "11,0",
      outdoor_muni_mesh: "11,1",
      outdoor_park: "11,2",
      outdoor_rest_area: "11,3",
      outdoor_traffic_control: "11,4",
      outdoor_bus_stop: "11,5",
      outdoor_kiosk: "11,6"
    }, default: "3,3"
  end

end