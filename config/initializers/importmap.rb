Spina.config.importmap.draw do
  pin_all_from Spina::Admin::Journal::Engine.root.join("app/assets/javascripts/spina/admin/journal/controllers"), under: "controllers", to: "spina/admin/journal/controllers"
end
