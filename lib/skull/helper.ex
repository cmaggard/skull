defmodule Skull.Helper do
  def generate_id do
    Integer.to_string(:rand.uniform(4_294_967_296), 32) <>
      Integer.to_string(:rand.uniform(4_294_967_296), 32)
  end
end
