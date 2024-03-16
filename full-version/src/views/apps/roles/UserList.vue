<script setup>
import { paginationMeta } from "@/@fake-db/utils";
import {
  addUser,
  changeRole,
  fetchAllUsers,
} from "@/services/Auth.service.vue";
import AddUserForm from "@/views/apps/user/AddUserForm.vue";
import AddNewUserDrawer from "@/views/apps/user/list/AddNewUserDrawer.vue";
import { useUserListStore } from "@/views/apps/user/useUserListStore";
import { avatarText } from "@core/utils/formatters";
import { VDataTableServer } from "vuetify/labs/VDataTable";

const userListStore = useUserListStore();
const searchQuery = ref("");
const selectedRole = ref();
const selectedPlan = ref();
const selectedStatus = ref();
const totalUsers = ref(0);
const users = ref([]);
const isAddUserDialogVisible = ref(false);

const options = ref({
  page: 1,
  itemsPerPage: 10,
  sortBy: [],
  groupBy: [],
  search: undefined,
});

const headers = [
  {
    title: "User",
    key: "user",
  },
  {
    title: "Role",
    key: "role",
  },
  {
    title: "Username",
    key: "username",
  },
  {
    title: "Email",
    key: "email",
  },
  {
    title: "Actions",
    key: "actions",
    sortable: false,
  },
];

// 👉 Fetching users
const fetchUsers = () => {
  fetchAllUsers()
    .then((response) => {
      console.log(response);
      users.value = response;
      totalUsers.value = response.length;
      //options.value.page = 1
    })
    .catch((error) => {
      console.error(error);
    });
};

watchEffect(fetchUsers);

// 👉 search filters
const roles = [
  {
    title: "Admin",
    value: "admin",
  },
  {
    title: "User",
    value: "user",
  },
  {
    title: "Employee",
    value: "employee",
  },
];

const resolveUserRoleVariant = (role) => {
  const roleLowerCase = role?.toLowerCase() || "";
  if (roleLowerCase === "user")
    return {
      color: "info",
      icon: "tabler-user",
    };
  if (roleLowerCase === "admin")
    return {
      color: "error",
      icon: "tabler-device-laptop",
    };

  if (roleLowerCase === "employee")
    return {
      color: "error",
      icon: "tabler-subscriber",
    };

  return {
    color: "primary",
    icon: "tabler-user",
  };
};

const resolveUserStatusVariant = (stat) => {
  const statLowerCase = stat.toLowerCase();
  if (statLowerCase === "pending") return "warning";
  if (statLowerCase === "active") return "success";
  if (statLowerCase === "inactive") return "secondary";

  return "primary";
};

const isAddNewUserDrawerVisible = ref(false);

const addNewUser = (userData) => {
  userListStore.addUser(userData);

  // refetch User
  fetchUsers();
};

const deleteUser = (id) => {
  userListStore.deleteUser(id);

  // refetch User
  fetchUsers();
};
// 👉 change role
const handleRoleChange = (id, newRole) => {
  changeRole(id, newRole).then((response) => {
    if (response) {
      console.log("Role changed successfully");
      // Refresh the user list to reflect the change
      fetchUsers();
    } else {
      console.error("Failed to change role");
    }
  });
};

const addUserToSystem = (
  userName,
  Email,
  password,
  FullName,
  PhoneNumber,
  role
) => {
  addUser(userName, Email, password, FullName, PhoneNumber, role).then(
    (response) => {
      if (response) {
        console.log("User added successfully");
        // Refresh the user list to reflect the change
        fetchUsers();
      } else {
        console.error("Failed to add user");
      }
    }
  );
};
</script>

<template>
  <section>
    <VCard>
      <VCardText class="d-flex flex-wrap gap-4">
        <div class="demo-space-x">
          <VDialog v-model="isAddUserDialogVisible" max-width="600px">
            <template #activator="{ props }">
              <VBtn @click="isAddUserDialogVisible = true" v-bind="props">
                Add user
              </VBtn>
            </template>
            <DialogCloseBtn
              @click="isAddUserDialogVisible = !isAddUserDialogVisible"
            />
            <AddUserForm @userAdded="addUserToSystem($event)" />
          </VDialog>
        </div>
        <!-- <AppSelect
          :model-value="options.itemsPerPage"
          :items="[
            { value: 10, title: '10' },
            { value: 25, title: '25' },
            { value: 50, title: '50' },
            { value: 100, title: '100' },
            { value: -1, title: 'All' },
          ]"
          style="width: 5rem;"
          @update:model-value="options.itemsPerPage = parseInt($event, 10)"
        /> -->

        <VSpacer />

        <div class="d-flex align-center flex-wrap gap-4">
          <!-- 👉 Search  -->
          <AppTextField
            v-model="searchQuery"
            placeholder="Search User"
            density="compact"
            style="width: 12.5rem"
          />

          <!-- 👉 Add user button -->
          <VSelect
            v-model="selectedRole"
            label="Select Role"
            :items="roles"
            density="compact"
            clearable
            clear-icon="tabler-x"
            style="width: 10rem"
          />
        </div>
      </VCardText>

      <VDivider />

      <!-- SECTION datatable -->
      <VDataTableServer
        v-model:items-per-page="options.itemsPerPage"
        v-model:page="options.page"
        :items="users"
        :items-length="totalUsers"
        :headers="headers"
        class="text-no-wrap"
        @update:options="options = $event"
      >
        <!-- User -->
        <template #item.user="{ item }">
          <div class="d-flex align-center">
            <VAvatar
              size="38"
              :variant="!item.raw.avatar ? 'tonal' : undefined"
              :color="
                !item.raw.avatar
                  ? resolveUserRoleVariant(item.raw.role).color
                  : undefined
              "
              class="me-3"
            >
              <VImg v-if="item.raw.avatar" :src="item.raw.avatar" />
              <span v-else>{{ avatarText(item.raw.fullName) }}</span>
            </VAvatar>
            <div class="d-flex flex-column">
              <h6 class="text-body-1 font-weight-medium">
                <RouterLink
                  :to="{
                    name: 'apps-user-view-id',
                    params: { id: item.raw.id },
                  }"
                  class="user-list-name"
                >
                  {{ item.raw.fullName }}
                </RouterLink>
              </h6>
              <span class="text-sm text-disabled">{{ item.raw.email }}</span>
            </div>
          </div>
        </template>

        <!-- Role -->
        <template #item.role="{ item }">
          <div class="d-flex align-center gap-4">
            <VAvatar
              size="30"
              variant="tonal"
              :color="resolveUserRoleVariant(item.raw.role).color"
            >
              <VIcon
                size="20"
                :icon="resolveUserRoleVariant(item.raw.role).icon"
              />
            </VAvatar>
            <span>
              <VSelect
                v-model="item.raw.role"
                :items="roles"
                density="compact"
                clearable
                clear-icon="tabler-x"
                style="width: 10rem"
                @update:modelValue="handleRoleChange(item.raw.id, $event)"
              />
            </span>
            <!-- <span class="text-capitalize">{{ item.raw.role }}</span> -->
          </div>
        </template>

        <template #bottom>
          <VDivider />

          <div
            class="d-flex align-center justify-sm-space-between justify-center flex-wrap gap-3 pa-5 pt-3"
          >
            <p class="text-sm text-disabled mb-0">
              {{ paginationMeta(options, totalUsers) }}
            </p>

            <VPagination
              v-model="options.page"
              :length="Math.ceil(totalUsers / options.itemsPerPage)"
              :total-visible="
                $vuetify.display.xs
                  ? 1
                  : Math.ceil(totalUsers / options.itemsPerPage)
              "
            >
              <template #prev="slotProps">
                <VBtn
                  variant="tonal"
                  color="default"
                  v-bind="slotProps"
                  :icon="false"
                >
                  Previous
                </VBtn>
              </template>

              <template #next="slotProps">
                <VBtn
                  variant="tonal"
                  color="default"
                  v-bind="slotProps"
                  :icon="false"
                >
                  Next
                </VBtn>
              </template>
            </VPagination>
          </div>
        </template>

        <!-- Actions -->
        <template #item.actions="{ item }">
          <IconBtn>
            <VIcon icon="tabler-edit" />
          </IconBtn>
          <IconBtn @click="deleteUser(item.raw.id)">
            <VIcon icon="tabler-trash" />
          </IconBtn>

          <VBtn
            icon
            color="medium-emphasis"
            density="comfortable"
            variant="text"
          >
            <VIcon size="24" icon="tabler-dots-vertical" />

            <VMenu activator="parent">
              <VList>
                <VListItem
                  :to="{
                    name: 'apps-user-view-id',
                    params: { id: item.raw.id },
                  }"
                >
                  <VListItemTitle>View</VListItemTitle>
                </VListItem>
                <VListItem link>
                  <VListItemTitle>Suspend</VListItemTitle>
                </VListItem>
              </VList>
            </VMenu>
          </VBtn>
        </template>
      </VDataTableServer>
      <!-- SECTION -->
    </VCard>

    <!-- 👉 Add New User -->
    <AddNewUserDrawer
      v-model:isDrawerOpen="isAddNewUserDrawerVisible"
      @user-data="addNewUser"
    />
  </section>
</template>

<style lang="scss">
.text-capitalize {
  text-transform: capitalize;
}

.user-list-name:not(:hover) {
  color: rgba(var(--v-theme-on-background), var(--v-medium-emphasis-opacity));
}
</style>
