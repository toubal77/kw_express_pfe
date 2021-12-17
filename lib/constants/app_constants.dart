enum Role {
  admin,
  client,
  restaurent,
}

const Map<Role, String> roleToText = {
  Role.client: 'User',
  Role.admin: 'Admin',
  Role.restaurent: 'Restaurent',
};
