post "/marvel-champions/hero/ally" do
  headers('Content-Type' => "image/png")

  ally = MarvelChampions::Ally.new({
    primary_color: @Params["primary_color"],
    secondary_color: @Params["secondary_color"],
    tertiary_color: @Params["tertiary_color"],
    resources: @Params["resources"],
    background_image_url: @Params["background_image_url"],
    set_icon_url: @Params["set_icon_url"],
    title: @Params["title"],
    subtitle: @Params["subtitle"],
    attributes: @Params["attributes"],
    description: @Params["description"],
    quote: @Params["quote"],
    set_name: @Params["set_name"],
    set_position: @Params["set_position"],
    cost: @Params["cost"]
  })


  ally.create_image()
end